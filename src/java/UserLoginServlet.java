// Source code is decompiled from a .class file using FernFlower decompiler.
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class UserLoginServlet extends HttpServlet {
   private String Load_Driver = "com.mysql.cj.jdbc.Driver";
   private String dbms_url = "jdbc:mysql://localhost:3306/ExploreHub?useSSL=false";
   private String dbms_user = "root";
   private String dbms_pass = "root";
   private String login_query = null;

   public UserLoginServlet() {
   }

   public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
      PrintWriter out = response.getWriter();
      String enroll_id = request.getParameter("enroll_id");
      String password = request.getParameter("password");
      this.login_query = "select * from users where enroll_id='" + enroll_id + "' and password='" + password + "'";
      out.println("<html><body>");

      try {
         Class.forName(this.Load_Driver);
         Connection connection = DriverManager.getConnection(this.dbms_url, this.dbms_user, this.dbms_pass);
         Statement statement = connection.createStatement();
         ResultSet resultSet = statement.executeQuery(this.login_query);
         if (resultSet.next()) {
            out.println("<h1>Welcome to home</h1>");
            response.sendRedirect("Main.html");
         }
      } catch (Exception e) {
         out.println(e);
      }

      out.println("</body></html>");
      out.close();
   }
}
