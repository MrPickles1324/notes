from os import system, listdir, chdir


def clean(dir):
    if dir != "/":
        chdir(dir)
    system('flutter clean')
    system('flutter pub get')
    if dir != '/':
        chdir('..')


def main():
    clean('/')
    dirs = listdir("packages")
    chdir("packages")
    for dir in dirs:
        clean(dir)


if __name__ == "__main__":
    main()
