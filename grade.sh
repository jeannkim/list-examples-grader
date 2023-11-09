CPATH='.:lib/hamcrest-core-1.3.jar:lib/junit-4.13.2.jar'

rm -rf student-submission
rm -rf grading-area

mkdir grading-area

git clone $1 student-submission
echo 'Finished cloning'

LISTEXAMPLES=`find . -type f -name "ListExamples.java"`

# does the submission contain the correct file
# -n "not empty"
if [[ -n $LISTEXAMPLES ]]; then
    echo "ListExamples.java found"
else
    echo "Uh oh! ListExamples.java not found. Please check the submission."
    exit
fi

# get all necessary stuff in the grading area
cp $LISTEXAMPLES grading-area
cp TestListExamples.java grading-area
cp -r lib grading-area

# compile
cd grading-area
javac ListExamples.java
javac -cp $CPATH TestListExamples.java

if [[ $? == 1 ]]; then
    echo "Compilation error in ListExamples. See above for information."
    exit
fi

# run tests
java -cp $CPATH org.junit.runner.JUnitCore TestListExamples > testoutput.txt

# get a useful output

if [[ `grep -c "OK" testoutput.txt` > 0 ]]; then
    # all tests passed
    echo "All tests passed!"
else
    # at least one failure
    # grep -n: gets line number + line matching pattern
    # cut -d: -f1 (use colon as delimiter, first field)
    # cut -d[delimiter] -f[field number] 

    RESULTLINE=`grep -n "Tests run:" testoutput.txt`
    TESTSRUN=`echo $RESULTLINE | cut -d: -f3 | cut -d, -f1`
    TESTSFAILED=`echo $RESULTLINE | cut -d: -f4`
    echo "$((TESTSRUN - TESTSFAILED)) /"$TESTSRUN "tests passed"
    echo "Grade: $(((TESTSRUN - TESTSFAILED)/$TESTSRUN))"
fi


# Draw a picture/take notes on the directory structure that's set up after
# getting to this point

# Then, add here code to compile and run, and do any post-processing of the
# tests
