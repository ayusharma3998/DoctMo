package com.doctmo.dto;

import java.time.LocalDateTime;

public record BookAppointmentRequest(Long patientId, Long doctorId, LocalDateTime time, String mode) {}
