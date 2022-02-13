package com.xjjc.report.controller;

import com.google.common.base.Strings;

import com.xiaoleilu.hutool.date.DateUtil;
import com.xjjc.report.util.QRCodeWriter;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.lang.invoke.MethodHandles;
import java.net.Inet4Address;
import java.net.InetAddress;
import java.net.URLEncoder;
import java.net.UnknownHostException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import java.util.UUID;

import javax.servlet.http.HttpServletResponse;

/**
 * 描述：<br> 版权：<br> 公司：<br> 作者：杨坤<br> 版本：1.0<br> 创建日期：2020/5/12<br>
 */
@Controller
@RequestMapping("/")
public class ReportController {

    private static final Logger LOGGER = LoggerFactory.getLogger(MethodHandles.lookup().lookupClass());

    @Value("${server.port}")
    private String port;

    private final String prefix = "/var/tmp";
    private final String workPath =  prefix +"/file";
    private final String tempPath = prefix + "/files";

    @RequestMapping("EXEC/0/{file}")
    public ModelAndView view(ModelAndView modelAndView, @PathVariable String file) {
        String fileName = file+ ".pdf";
        try {
            modelAndView.addObject("filePath", getUrl() + "/file/" + fileName);
            int year = DateUtil.thisYear();
            modelAndView.addObject("year", year);
        } catch (UnknownHostException e) {
            LOGGER.error("生成视图异常, ", e);
        }
        modelAndView.setViewName("/view");
        return modelAndView;
    }

    @RequestMapping("pdf/{file}")
    @ResponseBody
    public void pdf(@PathVariable("file") String file, HttpServletResponse response) {
        File pdfFile = new File(workPath + file + ".pdf");
        response.reset();
        response.setCharacterEncoding("UTF-8");
        response.setHeader("Content-Type", "application/pdf");
        try (InputStream input = new FileInputStream(pdfFile);
             OutputStream out = response.getOutputStream()) {
            output(input, out);
        } catch (Exception e) {
            LOGGER.error("下载文件异常,", e);
        }
    }

    @GetMapping("upload")
    public String upload() {
        try {
            File folder = new File(tempPath);
            if (!folder.exists()) {
                folder.mkdir();
            }
        } catch (Exception exception) {
            LOGGER.error("创建临时文件夹异常!");
        }
        return "/upload";
    }

    @PostMapping(value = "qrCode")
    public ModelAndView uploadFile(@RequestParam("file") MultipartFile file, ModelAndView model) {
        model.setViewName("/code");
        String fileName = UUID.randomUUID().toString().replaceAll("-", "");
        try {
            if (Strings.isNullOrEmpty(file.getOriginalFilename())) {
                model.addObject("message", "请返回上一页面上传文件！");
                return model;
            }

            // save file
            Path filePath = Paths.get(workPath + "/" + fileName + ".pdf");
            Files.copy(file.getInputStream(), filePath, StandardCopyOption.REPLACE_EXISTING);

            String url = getUrl();
            String content = url + "/EXEC/0/" + fileName;
            String codePath = workPath + "/C" + fileName + ".png";
            QRCodeWriter.createQRCode(content, codePath, 200, 200);

            model.addObject("fileName", "C" + fileName);
            model.addObject("url", url);
            model.addObject("image", url + "/file/" + "/C" + fileName + ".png");
        } catch (Exception ex) {
            LOGGER.error("文件上传失败! name:{}", file.getOriginalFilename(), ex);
            model.addObject("message", ex.getMessage());
        }
        return model;
    }

    @RequestMapping("download")
    @ResponseBody
    public void download(HttpServletResponse response, String fileName) {
        if (Strings.isNullOrEmpty(fileName)) {
            return;
        }
        String fullName = workPath + "/" + fileName + ".png";
        File file = new File(fullName);


        try (InputStream input = new FileInputStream(file);
             OutputStream out = response.getOutputStream()) {
            //设置response 响应头
            response.reset();
            response.setCharacterEncoding("UTF-8");
            response.setContentType("multipart/form-data");
            response.setHeader("Content-Disposition",
                    "attachment;fileName=" + URLEncoder.encode(fileName + ".png", "UTF-8"));
            output(input, out);
        } catch (Exception e) {
            LOGGER.error("下载文件异常,", e);
        }
    }

    private String getUrl() throws UnknownHostException {
        InetAddress localHost = Inet4Address.getLocalHost();
        String ip = localHost.getHostAddress();
        return "http://" + ip + ":" + port;
    }

    private void output(InputStream input, OutputStream out) throws IOException {
        byte[] buff = new byte[1024];
        int index;
        //4、执行 写出操作
        while ((index = input.read(buff)) != -1) {
            out.write(buff, 0, index);
            out.flush();
        }
    }
}
