package net.java_school.controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.net.URLEncoder;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.core.io.InputStreamResource;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;

@Controller
public class DownloadController {

    private static final String FILE_DIR = "./download/";

    @GetMapping("/download/{filename:.+}")
    public ResponseEntity<InputStreamResource> download(@PathVariable String filename, HttpServletRequest req) throws IOException {

        File file = new File(FILE_DIR + filename);
        
        InputStreamResource resource = new InputStreamResource(new FileInputStream(file));

        boolean ie = req.getHeader("User-Agent").indexOf("MSIE") != -1;
        if (ie) {
            filename = URLEncoder.encode(filename, "UTF-8").replaceAll("\\+", " ");
        } else {
            filename = new String(filename.getBytes("UTF-8"), "8859_1");
        }

        return ResponseEntity.ok()
                .header(HttpHeaders.CONTENT_DISPOSITION, "attachment;filename=\"" + filename + "\"")
                .contentType(MediaType.APPLICATION_OCTET_STREAM).contentLength(file.length())
                .body(resource);
    }
    
    @PostMapping("/download")
    public void download(String filename, HttpServletRequest req, HttpServletResponse resp) {
        OutputStream outputStream = null;

        try {
            File file = new File(FILE_DIR + filename);

            String filetype = filename.substring(filename.indexOf(".") + 1, filename.length());

            if (filetype.trim().equalsIgnoreCase("txt")) {
                resp.setContentType("text/plain");
            } else {
                resp.setContentType("application/octet-stream");
            }

            resp.setContentLength((int) file.length());

            boolean ie = req.getHeader("User-Agent").indexOf("MSIE") != -1;
            if (ie) {
                filename = URLEncoder.encode(filename, "UTF-8").replaceAll("\\+", " ");
            } else {
                filename = new String(filename.getBytes("UTF-8"), "8859_1");
            }

            resp.setHeader("Content-Disposition", "attachment; filename=\"" + filename + "\"");

            outputStream = resp.getOutputStream();
            FileInputStream fis = null;

            try {
                fis = new FileInputStream(file);
                FileCopyUtils.copy(fis, outputStream);
            } finally {
                if (fis!= null) {
                    fis.close();
                }
            }
        } catch (IOException e) {
            throw new RuntimeException(e);
        } finally {
            try {
                outputStream.close();
                resp.flushBuffer();
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
    }
}