## Directory per rank (mdtest-easy)

Each rank creates n files in their own directory of zero size. Multiple files are created in the directory.
All files are on the medata server
```bash
mdtest -n $n -u -L -F -P -G  -498257018 -N 1 -Y -a POSIX
```

## Single directory (mdtest-hard)

Mimics one single user creating a lot of files in their own directory. This should involve the OSTs during the stat operation.

```bash
mdtest -n $n -F -P -w 3901 -e 3901 -G -498257018 -N 1 -Y -a POSIX
```

## Python-like test 

Mimics the behaviour of python import 

```bash
mdtest -n $n -F -P -b 10 -z 1  -w 3901 -e 3901 -G -498257018 -N 1 -Y -a POSIX
```



