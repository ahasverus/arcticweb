library(yaml)

setwd("~/Desktop/arcticweb-project")
infos <- yaml.load_file("./data/_members.yml")

countries    <- unlist(lapply(infos, function(x) x[["country"]]))
affiliations <- unlist(lapply(infos, function(x) x[["affiliation"]]))
status       <- unlist(lapply(infos, function(x) x[["status"]]))
members      <- paste(
  unlist(lapply(infos, function(x) x[["last-name"]])),
  unlist(lapply(infos, function(x) x[["first-name"]])),
  sep = ", "
)

country   <- sort(unique(unlist(lapply(infos, function(x) x[["country"]]))))

html <- ""
html <- paste0(html, "<!doctype html>", sep = "\n")
html <- paste0(html, "<html lang=\"en\" xml:lang=\"en\" xmlns=\"http://www.w3.org/1999/xhtml\">", sep = "\n")
html <- paste0(html, "<head>", sep = "\n")
html <- paste0(html, "\n  <meta http-equiv=\"Content-Type\" content=\"text/html; charset=utf-8\" />", sep = "\n")
html <- paste0(html, "  <meta name=\"description\" content=\"Multidisciplinary arctic research network\">", sep = "\n")
html <- paste0(html, "  <meta name=\"author\" content=\"Nicolas Casajus\">", sep = "\n")
html <- paste0(html, "  <meta name=\"viewport\" content=\"width=device-width, initial-scale=1\">", sep = "\n")
html <- paste0(html, "\n  <title>ArcticWEB | Members</title>", sep = "\n")
html <- paste0(html, "\n  <link rel=\"stylesheet\" type=\"text/css\" href=\"css/font-awesome-4.3.0/css/font-awesome.min.css\">", sep = "\n")
html <- paste0(html, "  <link rel=\"stylesheet\" type=\"text/css\" href=\"css/custom-css.css\">", sep = "\n")
html <- paste0(html, "  <link rel=\"stylesheet\" type=\"text/css\" href=\"https://fonts.googleapis.com/css?family=Roboto\">", sep = "\n")
html <- paste0(html, "\n</head>", sep = "\n")

html <- paste0(html, "\n<body>", sep = "\n")
html <- paste0(html, "\n  <div class=\"container\">", sep = "\n")
html <- paste0(html, "\n    <!-- NAVBAR -------------------------------->", sep = "\n")
html <- paste0(html, "    <div class=\"topnav\" id=\"myTopnav\">", sep = "\n")
html <- paste0(html, "      <a href=\"index.html\"><i class=\"fa fa-home\"></i></a>", sep = "\n")
html <- paste0(html, "      <a href=\"research.html\">Research questions</a>", sep = "\n")
html <- paste0(html, "      <a href=\"monitoring.html\">Monitoring</a>", sep = "\n")
html <- paste0(html, "      <a href=\"members.html\" class=\"active\">Members</a>", sep = "\n")
html <- paste0(html, "      <a href=\"meetings.html\">Meetings</a>", sep = "\n")
html <- paste0(html, "      <a href=\"papers.html\">Publications</a>", sep = "\n")
html <- paste0(html, "      <a href=\"contact.html\">Contact</a>", sep = "\n")
html <- paste0(html, "      <a href=\"javascript:void(0);\" style=\"font-size:1em;\" class=\"icon\" onclick=\"myFunction()\">&#9776;</a>", sep = "\n")
html <- paste0(html, "    </div>", sep = "\n")
html <- paste0(html, "    <!-- END OF NAVBAR ------------------------->", sep = "\n")
html <- paste0(html, "\n\n    <!-- JUMBOTRON ----------------------------->", sep = "\n")
html <- paste0(html, "    <div class=\"jumbotron\">", sep = "\n")
html <- paste0(html, "      <div class=\"in-jumbotron\">", sep = "\n")
html <- paste0(html, "        <h1>ArcticWEB</h1>", sep = "\n")
html <- paste0(html, "        <h2>A Multi-disciplinary Arctic Research Network</h2>", sep = "\n")
html <- paste0(html, "      </div>", sep = "\n")
html <- paste0(html, "    </div>", sep = "\n")
html <- paste0(html, "    <!-- END OF JUMBOTRON ---------------------->", sep = "\n")

html <- paste0(html, "\n\n    <!-- PAGE TITLE ---------------------------->", sep = "\n")
html <- paste0(html, "    <div class=\"content-title\">", sep = "\n")
html <- paste0(html, "      <h3>", sep = "\n")
html <- paste0(html, "        <i class=\"fa fa-users fa-fw fa-1x\"></i>", sep = "\n")
html <- paste0(html, "        &nbsp;&nbsp;Members", sep = "\n")
html <- paste0(html, "      </h3>", sep = "\n")
html <- paste0(html, "    </div>", sep = "\n")
html <- paste0(html, "    <!-- END OF PAGE TITLE --------------------->", sep = "\n")

for (i in 1:length(country)) {

  html <- paste0(html, "\n\n    <!-- PAGE CONTENT -------------------------->", sep = "\n")
  html <- paste0(html, "    <div class=\"content\">", sep = "\n")
  html <- paste0(html, "      <div class=\"content-body\">", sep = "\n")
  html <- paste0(html, "        <h4>", sep = "\n")
  html <- paste0(html, "          <i class=\"fa fa-angle-double-right fa-fw fa-1x\"></i>", sep = "\n")
  html <- paste0(html, "          &nbsp;&nbsp;", country[i], sep = "\n")
  html <- paste0(html, "        </h4>", sep = "\n")

  members_sub      <- members[countries == country[i]]
  affiliations_sub <- affiliations[countries == country[i]]
  status_sub       <- status[countries == country[i]]

  pos <- order(members_sub)
  members_sub      <- members_sub[pos]
  affiliations_sub <- affiliations_sub[pos]
  status_sub       <- status_sub[pos]

  for (j in 1:length(members_sub)) {

    html <- paste0(html, "        <p>", sep = "\n")
    html <- paste0(html, "          <i class=\"fa fa-caret-right\"></i>", sep = "\n")
    html <- paste0(html, "          <em><strong>&nbsp;&nbsp;", members_sub[j], "</strong></em><br />", sep = "\n")
    html <- paste0(html, "          ", status_sub[j], " at ", affiliations_sub[j], sep = "\n")
    html <- paste0(html, "        </p>", sep = "\n")
  }

  html <- paste0(html, "      </div>", sep = "\n")
  html <- paste0(html, "    </div>", sep = "\n")
  html <- paste0(html, "    <!-- END OF PAGE CONTENT ------------------->", sep = "\n")
}

html <- paste0(html, "    <!-- FOOTER -------------------------------->", sep = "\n")
html <- paste0(html, "    <div class=\"footer\">", sep = "\n")
html <- paste0(html, "      &copy; ArcticWEB 2017. All rights reserved.", sep = "\n")
html <- paste0(html, "    </div>", sep = "\n")
html <- paste0(html, "    <!-- END OF FOOTER ------------------------->", sep = "\n")
html <- paste0(html, "\n\n  </div>", sep = "\n")

html <- paste0(html, "\n\n  <!-- JAVASCRIPT ------------------------------>", sep = "\n")
html <- paste0(html, "  <script src=\"js/jquery.min.js\"></script>", sep = "\n")
html <- paste0(html, "  <script>", sep = "\n")
html <- paste0(html, "    function myFunction() {", sep = "\n")
html <- paste0(html, "      var x = document.getElementById(\"myTopnav\");", sep = "\n")
html <- paste0(html, "      if (x.className === \"topnav\") {", sep = "\n")
html <- paste0(html, "        x.className += \" responsive\";", sep = "\n")
html <- paste0(html, "      } else {", sep = "\n")
html <- paste0(html, "        x.className = \"topnav\";", sep = "\n")
html <- paste0(html, "      }", sep = "\n")
html <- paste0(html, "    }", sep = "\n")
html <- paste0(html, "  </script>", sep = "\n")
html <- paste0(html, "  <!-- END OF JAVASCRIPT ----------------------->", sep = "\n")
html <- paste0(html, "\n\n</body>", sep = "\n")
html <- paste0(html, "</html>", sep = "\n")


cat(html, file = "members.html", append = FALSE)
