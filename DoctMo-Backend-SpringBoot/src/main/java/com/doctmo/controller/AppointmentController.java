package com.doctmo.controller;

import com.doctmo.dto.BookAppointmentRequest;
import com.doctmo.model.Appointment;
import com.doctmo.model.Doctor;
import com.doctmo.model.User;
import com.doctmo.repo.AppointmentRepo;
import com.doctmo.repo.DoctorRepo;
import com.doctmo.repo.UserRepo;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.*;

import java.time.LocalDateTime;
import java.util.List;

@RestController
@RequestMapping("/api/appointments")
@CrossOrigin
@RequiredArgsConstructor
public class AppointmentController {

    private final AppointmentRepo appointmentRepo;
    private final UserRepo userRepo;
    private final DoctorRepo doctorRepo;

    @PostMapping
    public Appointment book(@RequestBody BookAppointmentRequest req) {
        User patient = userRepo.findById(req.patientId()).orElseThrow();
        Doctor doctor = doctorRepo.findById(req.doctorId()).orElseThrow();
        Appointment a = Appointment.builder()
                .patient(patient)
                .doctor(doctor)
                .time(req.time())
                .mode(Appointment.Mode.valueOf(req.mode().toUpperCase()))
                .status(Appointment.Status.BOOKED)
                .build();
        return appointmentRepo.save(a);
    }

    @GetMapping("/patient/{patientId}")
    public List<Appointment> byPatient(@PathVariable Long patientId) {
        User p = userRepo.findById(patientId).orElseThrow();
        return appointmentRepo.findByPatient(p);
    }

    @PostMapping("/{id}/cancel")
    public Appointment cancel(@PathVariable Long id) {
        Appointment a = appointmentRepo.findById(id).orElseThrow();
        a.setStatus(Appointment.Status.CANCELLED);
        return appointmentRepo.save(a);
    }
}
