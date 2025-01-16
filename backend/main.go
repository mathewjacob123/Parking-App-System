package main
import (
    "encoding/json"
    "fmt"
    "net/http"
)

type User struct {
    ID           int    `json:"id"`
    Username     string `json:"username"`
    Password     string `json:"password"`
    Email        string `json:"email"`
    Phone        string `json:"phone"`
    VehicleType  string `json:"vehicle_type"`
    VehicleNumber string `json:"vehicle_number"`
    VehicleAPI   string `json:"vehicle_api"`
}
type Owner struct {
    ID            int    `json:"id"`
    Name          string `json:"name"`
    Password      string `json:"password"`
    Email         string `json:"email"`
    Phone         string `json:"phone"`
    Location      string `json:"location"`
    ParkingSpots  int    `json:"parking_spots"`
    SpaceType     string `json:"space_type"`
}

func main() {
    initDB()

    http.HandleFunc("/users", getUsers)
    http.HandleFunc("/register", registerUser)
    http.HandleFunc("/owners", getOwners)
    http.HandleFunc("/register_owner", registerOwner)

    fmt.Println("Server is running on port 8080")
    http.ListenAndServe("0.0.0.0:8080", nil)
}

func getUsers(w http.ResponseWriter, r *http.Request) {
    rows, err := db.Query("SELECT id, username, email, phone, vehicle_type, vehicle_number, vehicle_api FROM users")
    if err != nil {
        http.Error(w, err.Error(), http.StatusInternalServerError)
        return
    }
    defer rows.Close()

    var users []User
    for rows.Next() {
        var user User
        if err := rows.Scan(&user.ID, &user.Username, &user.Email, &user.Phone, &user.VehicleType, &user.VehicleNumber, &user.VehicleAPI); err != nil {
            http.Error(w, err.Error(), http.StatusInternalServerError)
            return
        }
        users = append(users, user)
    }

    w.Header().Set("Content-Type", "application/json")
    json.NewEncoder(w).Encode(users)
}

func registerUser(w http.ResponseWriter, r *http.Request) {
    if r.Method != http.MethodPost {
        http.Error(w, "Invalid request method", http.StatusMethodNotAllowed)
        return
    }

    var user User
    if err := json.NewDecoder(r.Body).Decode(&user); err != nil {
        http.Error(w, err.Error(), http.StatusBadRequest)
        return
    }

    result, err := db.Exec("INSERT INTO users (username, password, email, phone, vehicle_type, vehicle_number, vehicle_api) VALUES (?, ?, ?, ?, ?, ?, ?)",
        user.Username, user.Password, user.Email, user.Phone, user.VehicleType, user.VehicleNumber, user.VehicleAPI)
    if err != nil {
        http.Error(w, err.Error(), http.StatusInternalServerError)
        return
    }

    id, _ := result.LastInsertId()
    user.ID = int(id)

    w.Header().Set("Content-Type", "application/json")
    json.NewEncoder(w).Encode(user)
}
// Get all owners
func getOwners(w http.ResponseWriter, r *http.Request) {
    rows, err := db.Query("SELECT id, name, email, phone, location, parking_spots, space_type FROM owners")
    if err != nil {
        http.Error(w, err.Error(), http.StatusInternalServerError)
        return
    }
    defer rows.Close()

    var owners []Owner
    for rows.Next() {
        var owner Owner
        if err := rows.Scan(&owner.ID, &owner.Name, &owner.Email, &owner.Phone, &owner.Location, &owner.ParkingSpots, &owner.SpaceType); err != nil {
            http.Error(w, err.Error(), http.StatusInternalServerError)
            return
        }
        owners = append(owners, owner)
    }

    w.Header().Set("Content-Type", "application/json")
    json.NewEncoder(w).Encode(owners)
}

// Register a new owner
func registerOwner(w http.ResponseWriter, r *http.Request) {
    if r.Method != http.MethodPost {
        http.Error(w, "Invalid request method", http.StatusMethodNotAllowed)
        return
    }

    var owner Owner
    if err := json.NewDecoder(r.Body).Decode(&owner); err != nil {
        http.Error(w, err.Error(), http.StatusBadRequest)
        return
    }

    result, err := db.Exec("INSERT INTO owners (name, password, email, phone, location, parking_spots, space_type) VALUES (?, ?, ?, ?, ?, ?, ?)",
        owner.Name, owner.Password, owner.Email, owner.Phone, owner.Location, owner.ParkingSpots, owner.SpaceType)
    if err != nil {
        http.Error(w, err.Error(), http.StatusInternalServerError)
        return
    }

    id, _ := result.LastInsertId()
    owner.ID = int(id)

    w.Header().Set("Content-Type", "application/json")
    json.NewEncoder(w).Encode(owner)
}
