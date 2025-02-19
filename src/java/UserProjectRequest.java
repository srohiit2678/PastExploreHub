// Source code is decompiled from a .class file using FernFlower decompiler.
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class UserProjectRequest extends HttpServlet {
   public UserProjectRequest() {
   }

   public void doGet(HttpServletRequest var1, HttpServletResponse var2) throws IOException, ServletException {
      PrintWriter var3 = var2.getWriter();
      String var4 = var1.getParameter("projectName");
      String var5 = var1.getParameter("description");
      String var6 = var1.getParameter("mentorName");
      String var7 = var1.getParameter("githubLink");
      String var8 = var1.getParameter("liveLink");
      String var9 = var1.getParameter("challenges");
      String var10 = var1.getParameter("projectName");
      String var11 = "insert into projects (title,description,student_id,department_id,project_link,tech_stack)  values ('" + var4 + "','" + var5 + "','','" + var6 + "','" + var7 + "','','','" + var10 + "') ";
      var3.println("<html><body>");
      boolean var12 = true;

      try {
         Class.forName("com.mysql.cj.jdbc.Driver");
         Connection var13 = DriverManager.getConnection("jdbc:mysql:///ExploreHub?useSSL=false", "root", "root");
         if (var12) {
            var3.println("<center><h1>Your Project submited Successfully Wait For Guid Approve.</h1></center>");
         } else {
            var3.println("<center><h1>Your Project Not Submited Cheack Details Or Fill Again.</h1></center>");
         }

         var13.close();
      } catch (Exception var14) {
         var3.println(var14);
      }

      var3.println("</body></html>");
      var3.close();
   }
}
