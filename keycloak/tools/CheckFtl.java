package tools;

import java.io.*;
import freemarker.template.*;
import freemarker.core.HTMLOutputFormat;

public class CheckFtl {
  public static void main(String[] args) throws Exception {
    Configuration cfg = new Configuration(Configuration.VERSION_2_3_31);
    cfg.setDirectoryForTemplateLoading(new File("."));
    cfg.setDefaultEncoding("UTF-8");
    cfg.setOutputFormat(HTMLOutputFormat.INSTANCE); // Use HTML output format to avoid issues with special characters
    cfg.setTemplateExceptionHandler(TemplateExceptionHandler.RETHROW_HANDLER);

    for (String filename : args) {
      try {
        Template template = cfg.getTemplate(filename);
        System.out.println("✓ " + filename + " is valid.");
      } catch (Exception e) {
        System.err.println("✗ " + filename + " failed validation:");
        e.printStackTrace();
        System.exit(1);
      }
    }
  }
}
