package com.doctmo.repo;

import com.doctmo.model.Appointment;
import com.doctmo.model.Doctor;
import com.doctmo.model.User;
import org.springframework.data.jpa.repository.JpaRepository;

import java.time.LocalDateTime;
import java.util.List;

public interface AppointmentRepo extends JpaRepository<Appointment, Long> {
    List<Appointment> findByPatient(User u);
    List<Appointment> findByDoctorAndTimeBetween(Doctor d, LocalDateTime start, LocalDateTime end);
}
