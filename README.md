# The "Grandma Portal"

Super simple links and launcher buttons and nothing else

For Windows:

1. Have https://strawberryperl.com/ on your grandma's computer.
2. Have https://git-scm.com/download/win (or some variant) too.
3. Start the Strawberry Perl command terminal window, and then:
4. `git clone https://github.com/ology/Grandma-Portal.git`
5. `cd Grandma-Portal`
6. Copy the `config/default.yml` file, and name it for your grandma's Windows username, instead of "default".
7. Tweak the targets therein, to have her common actions, and then save the file. ***
7. `perl make-exe.pl`
8. Add `run-portal.exe` to your grandma's scheduled startup tasks.
9. Reboot her machine...
10. Browse to http://127.0.0.0:3000/
11. Voila!

*** To launch a Windows EXE, use the path to the program you want to run.

It is assumed to live under `Program Files`. So for good ol' Win7 Solitaire installed at,

   C:\Program Files\Microsoft Games\Solitaire\Solitaire.exe

the `config/your_grandma.yml` would have this buttons entry:

    buttons:
      - text: 'Solitaire'
        fa: 'fa-diamond'
        target: 'Microsoft Games\Solitaire\Solitaire'

