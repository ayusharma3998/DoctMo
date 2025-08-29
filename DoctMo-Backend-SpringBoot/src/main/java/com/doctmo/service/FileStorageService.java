package com.doctmo.service;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.UUID;

@Service
public class FileStorageService {

    private final Path uploadDir;

    public FileStorageService(@Value("${file.upload-dir}") String dir) throws IOException {
        this.uploadDir = Paths.get(dir);
        Files.createDirectories(this.uploadDir);
    }

    public String save(MultipartFile file) throws IOException {
        String original = StringUtils.cleanPath(file.getOriginalFilename() == null ? "file" : file.getOriginalFilename());
        String filename = UUID.randomUUID() + "-" + original;
        Path dest = uploadDir.resolve(filename);
        Files.copy(file.getInputStream(), dest);
        return dest.toString();
    }
}
