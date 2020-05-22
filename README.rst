====
markx
====

|nimble-version| |nimble-install| |gh-actions|

markx selects execution targets with editor and executes commands.

.. contents:: Table of contents

Usage
=====

markx read targets from stdin or command line args.
markx opens a tmp file with a default editor (``vi``, or ``EDITOR`` of environment variables) when markx started.
markx filters that as targets if you wrote ``x`` to prefix of lines of buffer of your editor.
markx executes command string to filtered targets.
The ``{}`` of command string is replaced with filtered target when markx executes that.

.. code-block:: shell

   $ markx -c 'command string' <args...>

   $ <command> | markx -c 'command string'

Echo example is below.

.. code-block:: shell

   $ markx -c 'echo "target is {} ."' src/*.nim
   $ ls src/*.nim | markx -c 'echo "target is {} ."'

You can use ``rm`` command if you want to remove any files.

.. code-block:: shell

   $ markx -c 'rm -f {}' src/*.nim

And you can use shell-pipe.

.. code-block:: shell

   $ find . -type f | grep -v -e node_modules -e .git/ | grep example | markx -c 'echo {}'

You quit editor without save file if you want to stop executing commands.

Examples
========

See ``bin`` directory.

Installation
============

.. code-block:: shell

   $ nimble install -Y markx

LICENSE
=======

MIT

.. |gh-actions| image:: https://github.com/jiro4989/markx/workflows/build/badge.svg
   :target: https://github.com/jiro4989/markx/actions
.. |nimble-version| image:: https://nimble.directory/ci/badges/markx/version.svg
   :target: https://nimble.directory/ci/badges/markx/nimdevel/output.html
.. |nimble-install| image:: https://nimble.directory/ci/badges/markx/nimdevel/status.svg
   :target: https://nimble.directory/ci/badges/markx/nimdevel/output.html
