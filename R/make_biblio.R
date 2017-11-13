library(yaml)

setwd("~/Desktop/arcticweb-project")

files <- list.files("./publis/", pattern = "\\.yml", full.names = TRUE)

metadata <- list()

for (i in 1:length(files)) {

  metadata[[i]] <- yaml.load_file(files[i])$references[[1]]
  AU <- NULL
  for (j in 1:length(metadata[[i]]$author)) {
    tags <- names(metadata[[i]]$author[[j]])
    author <- NULL
    if (length(which(tags == "dropping-particle"))) {
      author <- c(author, metadata[[i]]$author[[j]][[which(tags == "dropping-particle")]])
    }
    if (length(which(tags == "family"))) {
      author <- c(author, metadata[[i]]$author[[j]][[which(tags == "family")]])
    }
    if (length(which(tags == "given"))) {
      author <- c(author, metadata[[i]]$author[[j]][[which(tags == "given")]])
    }
    AU[j] <- paste0(author, collapse = " ")
  }
  metadata[[i]]$author <- paste0(AU, collapse = ", ")


}

tosort <- data.frame(
  year   = as.numeric(
    as.character(
      unlist(
        lapply(
          metadata,
          function(x) x$issued[[1]]$year
        )
      )
    )
  ),
  author = as.character(
    unlist(
      lapply(
        metadata,
        function(x) x$author
      )
    )
  )
)

pos <- with(
  tosort,
  order(-year, author)
)

metadata <- metadata[pos]
files <- files[pos]


## Remove no references w/o authors

no_authors <- unlist(lapply(metadata, function(x) x$author))
sop <- which(no_authors == "")

if (length(sop) > 0) {
  metadata <- metadata[-sop]
  files <- files[-sop]
}


thrs <- unlist(lapply(metadata, function(x) x$author))
ttes <- unlist(lapply(metadata, function(x) x$title))
nene <- as.numeric(as.character(unlist(lapply(metadata, function(x) x$issued[[1]]$year))))


todel <- NULL
pos1 <- grep("Sokolov A", thrs)
if (length(pos1) > 0) {
  pos2 <- which(nene[pos1] < 2010)
  if (length(pos2) > 0) {
    todel <- pos1[pos2]
  }
}
pos3 <- grep("fuel and energy complex|quadratic cost", ttes)
if (length(pos3) > 0) {
  todel <- c(todel, pos3)
}

if (length(todel) > 0) {
  metadata <- metadata[-todel]
  files <- files[-todel]
}


html <- ""
html <- paste0(html, "<!doctype html>", sep = "\n")
html <- paste0(html, "<html lang=\"en\" xml:lang=\"en\" xmlns=\"http://www.w3.org/1999/xhtml\">", sep = "\n")
html <- paste0(html, "<head>", sep = "\n")
html <- paste0(html, "\n  <meta http-equiv=\"Content-Type\" content=\"text/html; charset=utf-8\" />", sep = "\n")
html <- paste0(html, "  <meta name=\"description\" content=\"Multidisciplinary arctic research network\">", sep = "\n")
html <- paste0(html, "  <meta name=\"author\" content=\"Nicolas Casajus\">", sep = "\n")
html <- paste0(html, "  <meta name=\"viewport\" content=\"width=device-width, initial-scale=1\">", sep = "\n")
html <- paste0(html, "\n  <title>ArcticWEB | Publications</title>", sep = "\n")
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
html <- paste0(html, "      <a href=\"members.html\">Members</a>", sep = "\n")
html <- paste0(html, "      <a href=\"meetings.html\">Meetings</a>", sep = "\n")
html <- paste0(html, "      <a href=\"papers.html\" class=\"active\">Publications</a>", sep = "\n")
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
html <- paste0(html, "        <i class=\"fa fa-file-text fa-fw fa-1x\"></i>", sep = "\n")
html <- paste0(html, "        &nbsp;&nbsp;Publications", sep = "\n")
html <- paste0(html, "      </h3>", sep = "\n")
html <- paste0(html, "      <p>(Publications produced by ArcticWEB members)</p>", sep = "\n")
html <- paste0(html, "    </div>", sep = "\n")
html <- paste0(html, "    <!-- END OF PAGE TITLE --------------------->", sep = "\n")

cat(html, file = "papers.html", append = FALSE)

for (i in 1:length(metadata)) {

  html <- ""

  if (i == 1) {

    html <- paste0(html, "\n\n    <!-- PAGE CONTENT -------------------------->", sep = "\n")
    html <- paste0(html, "    <div class=\"content\">", sep = "\n")
    html <- paste0(html, "      <div class=\"content-body\">", sep = "\n")
    html <- paste0(html, "        <h4>", sep = "\n")
    html <- paste0(html, "          <i class=\"fa fa-angle-double-right fa-fw fa-1x\"></i>", sep = "\n")
    html <- paste0(html, "          &nbsp;&nbsp;", metadata[[i]]$issued[[1]]$year, sep = "\n")
    html <- paste0(html, "        </h4>", sep = "\n")
  } else {
    if (metadata[[i]]$issued[[1]]$year != metadata[[i-1]]$issued[[1]]$year) {
      html <- paste0(html, "      </div>", sep = "\n")
      html <- paste0(html, "    </div>", sep = "\n")
      html <- paste0(html, "    <!-- END OF PAGE CONTENT ------------------->", sep = "\n")
      html <- paste0(html, "\n\n    <!-- PAGE CONTENT -------------------------->", sep = "\n")
      html <- paste0(html, "    <div class=\"content\">", sep = "\n")
      html <- paste0(html, "      <div class=\"content-body\">", sep = "\n")
      html <- paste0(html, "        <h4>", sep = "\n")
      html <- paste0(html, "          <i class=\"fa fa-angle-double-right fa-fw fa-1x\"></i>", sep = "\n")
      html <- paste0(html, "          &nbsp;&nbsp;", metadata[[i]]$issued[[1]]$year, sep = "\n")
      html <- paste0(html, "        </h4>", sep = "\n")
    }
  }

  oid <- (length(metadata) - i + 1)
  oid <- paste0("00000", oid)
  oid <- substr(oid, nchar(oid) - (nchar(length(metadata)) - 1), nchar(oid))

  html <- paste0(html, "        <p class='biblio'>")
  html <- paste0(html, "<b># ", oid, "&nbsp;&nbsp;")
  if (length(which(names(metadata[[i]]) == "DOI")) > 0){
    html <- paste0(html, "<a href=\"http://doi.org/")
    html <- paste0(html, metadata[[i]]$DOI)
    html <- paste0(html, "\" target=\"_blank\">")
  } else {
    if (length(which(names(metadata[[i]]) == "URL")) > 0){
      html <- paste0(html, "<a href=\"")
      html <- paste0(html, metadata[[i]]$URL)
      html <- paste0(html, "\" target=\"_blank\">")
    }
  }
  html <- paste0(html, metadata[[i]]$title, "</b>")
  if (length(which(names(metadata[[i]]) %in% c("DOI", "URL"))) > 0){
    html <- paste0(html, "</a>")
  }

  html <- paste0(html, "<br />")
  html <- paste0(html, metadata[[i]]$author)
  html <- paste0(html, "<br />")
  html <- paste0(html, metadata[[i]]$issued[[1]]$year)
  html <- paste0(html, " &mdash;")
  html <- paste0(html, " ")
  html <- paste0(html, "<em>")
  html <- paste0(html, metadata[[i]]$"container-title")
  html <- paste0(html, "</em>")
  html <- paste0(html, "        </p>")
  html <- c(paste0(html, "\n"))

  html <- gsub("\\?\\.|\\!\\.|\\.+", "\\.", html)
  html <- gsub("[[:space:]]{2}", " ", html)
  cat(html, file = "papers.html", append = TRUE)
}

html <- ""
html <- paste0(html, "      </div>", sep = "\n")
html <- paste0(html, "    </div>", sep = "\n")
html <- paste0(html, "    <!-- END OF PAGE CONTENT ------------------->", sep = "\n")

html <- paste0(html, "\n\n    <!-- FOOTER -------------------------------->", sep = "\n")
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

html <- gsub("\\?\\.|\\!\\.|\\.+", "\\.", html)
html <- gsub("[[:space:]]{2}", " ", html)

cat(html, file = "papers.html", append = TRUE)
