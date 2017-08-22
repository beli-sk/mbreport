MbReport
========

Per mailbox/domain stats from Zimbra mail server.

Usage
-----

    sudo -iu zimbra
    # mailbox report
    ./mbreport.sh | ./parse.py > report.csv
    # domain report
    ./domreport.sh > domreport.csv

Mailbox report contains the following fields:

* domain name
* mailbox name
* status
* size (with unit)
* size (KB)
* date created
* date of last login

At the end of the report is a summary per domain with number of mailboxes and total size in KB.

License
-------

Copyright &copy; 2017 Michal Belica <devel@beli.sk>

    This program is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with this program.  If not, see <http://www.gnu.org/licenses/>.
