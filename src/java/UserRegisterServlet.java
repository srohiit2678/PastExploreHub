// Source code is decompiled from a .class file using FernFlower decompiler.
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.Statement;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class UserRegisterServlet extends HttpServlet {
   private String Load_Driver = "com.mysql.cj.jdbc.Driver";
   private String dbms_url = "jdbc:mysql://localhost:3306/ExploreHub?useSSL=false";
   private String dbms_user = "root";
   private String dbms_pass = "root";
   private String Register_query = null;

   public UserRegisterServlet() {
   }

   public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
      PrintWriter out = response.getWriter();
      String name = request.getParameter("name");
      String enroll_id = request.getParameter("enroll_id");
      String email = request.getParameter("email");
      int department = Integer.parseInt(request.getParameter("department"));
      String roll_Type = request.getParameter("type");
      String password = request.getParameter("password");
      this.Register_query = "INSERT INTO Users (enroll_id, name, email, password, role, department_id) values ('" + enroll_id + "','" + name + "','" + email + "','" + password + "','" + roll_Type + "'," + department + ")";
      out.println("<html><body>");

      try {
         Class.forName(this.Load_Driver);
         Connection connection = DriverManager.getConnection(this.dbms_url, this.dbms_user, this.dbms_pass);
         Statement statement = connection.createStatement();
         int effects = statement.executeUpdate(this.Register_query);
         if (effects != 0) {
            out.println("<h1>register Successfully</h1>");
            response.sendRedirect("login.html");
         } else {
            out.println("<h1>Registeration Not Done Successfully</h1>");
         }

         connection.close();
      } catch (Exception e) {
         out.println(e);
      }

   }
}
