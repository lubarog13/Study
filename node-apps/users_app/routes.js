const fs = require("fs");

const requestHandler = (req, res) => {
    const url = req.url;
    const method = req.method;
  if (url === "/") {
    res.write("<html>");
    res.write("<head><title>Enter User</title><head>");
    res.write("<h1>Hello in my app!</h1>")
    res.write(
      '<body><form action="/create-user" method="POST"><input type="text" name="username" placeholder="Enter user..."><button type="submit">Send</button></form></body>'
    );
    res.write("</html>");
    return res.end();
  }
  else if (url === "/create-user" && method === "POST") {
    const body = [];
    req.on("data", (chunk) => {
      body.push(chunk);
    });
    req.on("end", () => {
      const parsedBody = Buffer.concat(body).toString();
      const user = parsedBody.split("=")[1];
      console.log(user)
      res.statusCode = 302;
      res.setHeader("Location", "/users");
      return res.end();
    });
  }
  else if(url==="/users") {
  res.setHeader("Content-Type", "text/html");
  res.write("<html>");
  res.write("<head><title>Users Page</title><head>");
  res.write("<body><ul><li>User 1</li><li>User 2</li><li>User 3</li></ul></body>");
  res.write("</html>");
  res.end();
  }
  else {
  res.setHeader("Content-Type", "text/html");
  res.write("<html>");
  res.write("<head><title>404 error</title><head>");
  res.write("<body><h1>Page not found!</h1></body>");
  res.write("</html>");
  res.end();
  }
};

module.exports = requestHandler;