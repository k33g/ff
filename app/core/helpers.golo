module helpers

function reload = |request, response| {
    ff.Reload.all(ff.Parameters.appDirectory())
    response:type("text/html")

    let html = """
<!DOCTYPE html>
<html>
<head>
    <title>Bug Tracker</title>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
    <meta name="viewport" content="width=device-width,initial-scale=1,maximum-scale=1">
    <link href="bootstrap3/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            position: relative;
            padding-top: 60px;
        }
    </style>
<body>
    <div class="container">
        <div class="alert alert-success">SCRIPTS RELOADED <a href='/'>return to home</a></div>
    </div>
</body>
    """

    return html
}
