package com.doctmo.controller;

import com.doctmo.model.Doctor;
import com.doctmo.repo.DoctorRepo;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/doctors")
@CrossOrigin
@RequiredArgsConstructor
public class DoctorController {

    private final DoctorRepo doctorRepo;

    @GetMapping
    public List<Doctor> list(@RequestParam(value = "q", required = false) String q) {
        if (q == null || q.isBlank()) return doctorRepo.findAll();
        return doctorRepo.findBySpecializationContainingIgnoreCase(q);
    }

    @GetMapping("/{id}")
    public Doctor get(@PathVariable Long id) {
        return doctorRepo.findById(id).orElseThrow();
    }
}
