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

    private String Project_query = null;
    
   public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
      PrintWriter out = response.getWriter();
      String projectName = request.getParameter("projectName");
      String description = request.getParameter("description");
      String mentorName = request.getParameter("mentorName");
      String githubLink = request.getParameter("githubLink");
      String liveLink = request.getParameter("liveLink");
      String challenges = request.getParameter("challenges");
      this.Project_query = "insert into projects (title,description,student_id,department_id,project_link,tech_stack)  values ('" + projectName + "','" + description + "','','" + mentorName + "','" + githubLink + "','','','" + projectName + "') ";
      out.println("<html><body>");
      boolean project_Submit = true;
      try {
         Class.forName("com.mysql.cj.jdbc.Driver");
         Connection connection = DriverManager.getConnection("jdbc:mysql:///ExploreHub?useSSL=false", "root", "root");
         if (project_Submit) {
            out.println("<center><h1>Your Project submited Successfully Wait For Guid Approve.</h1></center>");
         } else {
            out.println("<center><h1>Your Project Not Submited Cheack Details Or Fill Again.</h1></center>");
         }

         connection.close();
      } catch (Exception e) {
         out.println(e);
      }

      out.println("</body></html>");
      out.close();
   }
}
