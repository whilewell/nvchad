qtag(){
    root_dir=`pwd`
    find $root_dir -name "*.h" -o -name "*.c" > cscope.files
    cscope -Rbkq -i cscope.files
    ctags -R
}
