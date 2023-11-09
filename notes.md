```
# is there a file called ListExamples.java in submission
# search using find
# pipe sends find output to grep 
# which returns true if there is output ('.' is regex for any char)
# -q means grep 

if find . -type f -name "filename" -print -quit | grep -q '.'; then
  echo "File exists."
else
  echo "File does not exist."
fi

```