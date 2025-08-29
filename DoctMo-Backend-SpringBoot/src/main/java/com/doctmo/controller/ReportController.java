package com.doctmo.controller;

import com.doctmo.model.Report;
import com.doctmo.model.User;
import com.doctmo.repo.ReportRepo;
import com.doctmo.repo.UserRepo;
import com.doctmo.service.FileStorageService;
import lombok.RequiredArgsConstructor;
import org.springframework.core.io.FileSystemResource;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.time.LocalDateTime;
import java.util.List;

@RestController
@RequestMapping("/api/reports")
@CrossOrigin
@RequiredArgsConstructor
public class ReportController {

    private final ReportRepo reportRepo;
    private final UserRepo userRepo;
    private final FileStorageService storage;

    @PostMapping(consumes = MediaType.MULTIPART_FORM_DATA_VALUE)
    public Report upload(@RequestParam Long patientId,
                         @RequestParam String labName,
                         @RequestParam String type,
                         @RequestParam MultipartFile file) throws Exception {
        User p = userRepo.findById(patientId).orElseThrow();
        String path = storage.save(file);
        Report r = Report.builder()
                .patient(p)
                .labName(labName)
                .type(type)
                .filePath(path)
                .uploadedAt(LocalDateTime.now())
                .build();
        return reportRepo.save(r);
    }

    @GetMapping("/patient/{patientId}")
    public List<Report> list(@PathVariable Long patientId) {
        User p = userRepo.findById(patientId).orElseThrow();
        return reportRepo.findByPatient(p);
    }

    @GetMapping("/{id}/download")
    public ResponseEntity<FileSystemResource> download(@PathVariable Long id) {
        Report r = reportRepo.findById(id).orElseThrow();
        File file = new File(r.getFilePath());
        FileSystemResource res = new FileSystemResource(file);
        return ResponseEntity.ok()
                .header(HttpHeaders.CONTENT_DISPOSITION, "attachment; filename=" + file.getName())
                .contentLength(file.length())
                .contentType(MediaType.APPLICATION_OCTET_STREAM)
                .body(res);
    }
}
