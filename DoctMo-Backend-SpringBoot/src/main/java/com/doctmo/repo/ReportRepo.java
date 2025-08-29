package com.doctmo.repo;

import com.doctmo.model.Report;
import com.doctmo.model.User;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface ReportRepo extends JpaRepository<Report, Long> {
    List<Report> findByPatient(User u);
}
