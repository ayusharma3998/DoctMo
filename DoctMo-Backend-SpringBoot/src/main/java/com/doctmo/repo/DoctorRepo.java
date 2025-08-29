package com.doctmo.repo;

import com.doctmo.model.Doctor;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface DoctorRepo extends JpaRepository<Doctor, Long> {
    List<Doctor> findBySpecializationContainingIgnoreCase(String specialization);
}
