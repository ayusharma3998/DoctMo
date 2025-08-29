**DoctMo** is a full-stack digital healthcare solution that connects **patients, doctors, and labs** on a single platform.  
It allows patients to **book appointments, upload/view medical reports, and manage health records** — all through a **SwiftUI iOS app** powered by a **Spring Boot backend**.  

---

## 🚀 Features
- 👨‍⚕️ **Doctor Appointments** – Browse/search doctors by specialization, view details, and book online/offline consultations  
- 📅 **Appointments** – View upcoming and past visits  
- 📄 **Reports Management** – Patients upload personal reports; labs securely upload test results  
- 🧾 **Health Records** – Centralized history of appointments, prescriptions, and reports  
- 👤 **User Profiles** – Personalized dashboard for patients  
- 🔔 **Notifications & Reminders** – Stay informed about upcoming appointments and new reports  
- 🎨 **Modern UI** – SwiftUI-based polished design with launch splash screen  

---

## 🛠️ Tech Stack

### Frontend (iOS)
- **Framework** → SwiftUI (iOS 16+)  
- **Language** → Swift 5  
- **Networking** → async/await with `URLSession`  
- **Assets** → App Icon placeholder, LaunchView splash screen  

### Backend (Spring Boot)
- **Framework** → Spring Boot 3  
- **Database** → H2 (in-memory, seeded with sample data)  
- **Build Tool** → Maven  
- **APIs** → REST (JSON), Multipart (file uploads)  

---

## 📂 Project Structure
```
DoctMo/
 ├─ frontend/DoctMo-Frontend-Swift/
 │   ├─ DoctMo.xcodeproj/        # Xcode project file
 │   ├─ Assets.xcassets/         # App icons & brand colors
 │   ├─ DoctMoApp.swift          # Entry point
 │   ├─ LaunchView.swift         # Splash screen
 │   ├─ RootView.swift           # Handles login vs. main flow
 │   ├─ LoginView.swift          # Login screen
 │   ├─ MainTabView.swift        # Tab navigation
 │   ├─ DoctorsView.swift        # Doctor list/search
 │   ├─ DoctorDetailView.swift   # Doctor detail & booking
 │   ├─ AppointmentsView.swift   # Appointments screen
 │   ├─ ReportsView.swift        # Reports upload & list
 │   ├─ ProfileView.swift        # Patient profile
 │   ├─ Models.swift             # Data models
 │   └─ APIClient.swift          # Networking client
 │
 ├─ backend/DoctMo-Backend-SpringBoot/
 │   ├─ src/main/java/com/doctmo/
 │   │   ├─ controller/     # REST controllers
 │   │   ├─ model/          # Entities (User, Doctor, Appointment, Report)
 │   │   ├─ repository/     # JPA repositories
 │   │   ├─ service/        # Business logic
 │   │   └─ DoctMoApp.java  # Main application
 │   ├─ src/main/resources/
 │   │   ├─ application.properties  # Config
 │   │   └─ data.sql                # Seed data
 │   └─ pom.xml
 │
 └─ README.md   # Project overview (this file)
```

---

## ▶️ Running the Project

### 1. Backend (Spring Boot)
```bash
cd backend/DoctMo-Backend-SpringBoot
./mvnw spring-boot:run
```
- Runs on: `http://localhost:8080`  
- H2 Console: `http://localhost:8080/h2-console`  
  - JDBC URL: `jdbc:h2:mem:testdb`  
  - User: `sa` | Password: *(blank)*  

### 2. Frontend (iOS App)
1. Open `frontend/DoctMo-Frontend-Swift/DoctMo.xcodeproj` in **Xcode**  
2. Set **Deployment Target = iOS 16**  
3. Update `APIClient.baseURL` if running on a physical device (replace `localhost` with your machine’s IP)  
4. Run on Simulator (⌘R)  

---

## 📌 API Endpoints

### 👨‍⚕️ Doctors
- `GET /api/doctors` → Get all doctors  
- `GET /api/doctors?q=cardiology` → Search doctors  

### 📅 Appointments
- `POST /api/appointments` → Book appointment  
- `GET /api/appointments/patient/{id}` → Patient appointments  

### 📄 Reports
- `POST /api/reports` → Upload report (multipart file)  
- `GET /api/reports/patient/{id}` → Patient reports  

---

## 🔮 Future Enhancements
- ✅ JWT authentication & secure login/signup  
- ✅ Persistent storage for reports (AWS S3 / local file system)  
- ✅ Online video consultations  
- ✅ Insurance/health integration  
- ✅ Health insights dashboard  

---

✨ **DoctMo makes healthcare simpler, smarter, and digital.**  
"""
