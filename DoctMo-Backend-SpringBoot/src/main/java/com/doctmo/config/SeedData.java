package com.doctmo.config;

import com.doctmo.model.Doctor;
import com.doctmo.model.User;
import com.doctmo.repo.DoctorRepo;
import com.doctmo.repo.UserRepo;
import org.springframework.boot.CommandLineRunner;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

@Configuration
public class SeedData {

    @Bean
    CommandLineRunner init(UserRepo users, DoctorRepo doctors) {
        return args -> {
            if (users.count() == 0) {
                User p1 = users.save(User.builder().name("Ayush Sharma").email("ayush@example.com").phone("9999999999").role(User.Role.PATIENT).build());
                User d1u = users.save(User.builder().name("Dr. Neha Mehta").email("neha@example.com").phone("8888888888").role(User.Role.DOCTOR).build());
                User d2u = users.save(User.builder().name("Dr. Arjun Rao").email("arjun@example.com").phone("7777777777").role(User.Role.DOCTOR).build());

                doctors.save(Doctor.builder().user(d1u).specialization("Cardiologist").experienceYears(10).clinicAddress("Mumbai").build());
                doctors.save(Doctor.builder().user(d2u).specialization("Dermatologist").experienceYears(7).clinicAddress("Pune").build());
            }
        };
    }
}
