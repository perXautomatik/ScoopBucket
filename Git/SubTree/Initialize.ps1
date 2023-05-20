git init #initialize folder

''> .gitignore # add something to commit
git add .gitignore
git commit -m "initial commit"

    # fetch a exsisting repo to tree
git remote add -f VisionFilInsert "C:\Users\crbk01\AppData\Roaming\JetBrains\DataGrip2021.1\consoles\db\49f168c8-015c-43d2-b9f4-06de275bdc15\.git"
git fetch VisionFilInsert

    # store repo at prefix, git in root, 
git read-tree --prefix=/ -u VisionFilInsert/withoutIDeax