#!/usr/bin/perl -p

BEGIN {
print <<END
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">
<head>
    <title>The Official YAML Web Site</title>
    <meta charset="UTF-8">
    <link rel="stylesheet" type="text/css" href="style.css" media="screen" />
</head>
<body>
<pre class="content">
END
}

s/^\s*%(YAML|TAG).*$/<span class="yaml_directive">$&<\/span>/g;
s/^\s*---\s*$/<span class="yaml_doc_sep">$&<\/span>/g;
s/^\s*\K([(ö).+\/\w -]+):/<span class="yaml_key">$1<\/span><span class="yaml_key_sep">:<\/span>/g;
s/^\s-\s*\K(.*?): /<span class="yaml_key">$1<\/span><span class="yaml_key_sep">:<\/span>/g;
s/\[([^\]]+)\]\(([^\)]+)\)/<a href="$2">$1<\/a>/g;
s/\#[^}]*$/<span class="yaml_comment">$&<\/span>/g;
s/^\s+-/<span class="yaml_dash">$&<\/span>/g;
s/[{}]/<span class="yaml_bracket">$&<\/span>/g;
s/'/<span class="yaml_quote">$&<\/span>/g;
s/\bYAML\b/<strong>$&<\/strong>/g;
END {
print <<END
</pre>
</body> 
</html>      
END
}
