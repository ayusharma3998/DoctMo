package com.doctmo.model;

import jakarta.persistence.*;
import lombok.*;

import java.time.LocalDateTime;

@Entity @Getter @Setter @NoArgsConstructor @AllArgsConstructor @Builder
public class Appointment {
    @Id @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne
    private User patient;

    @ManyToOne
    private Doctor doctor;

    private LocalDateTime time;

    @Enumerated(EnumType.STRING)
    private Status status;

    @Enumerated(EnumType.STRING)
    private Mode mode;

    public enum Status { BOOKED, CANCELLED, COMPLETED }
    public enum Mode { ONLINE, OFFLINE }
}
