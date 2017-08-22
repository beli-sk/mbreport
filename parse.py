#!/usr/bin/env python
#
# MbReport - per mailbox stats from Zimbra mail server
# Copyright (C) 2017 Michal Belica <devel@beli.sk>
#
# This file is part of MbReport.
#
# MbReport is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# MbReport is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with MbReport.  If not, see <http://www.gnu.org/licenses/>.
#
import csv
import sys
from pprint import pprint

domsize = {}
domcount = {}

writer = csv.writer(sys.stdout)
reader = csv.reader(sys.stdin)
for line in reader:
    domain = line[0].split('@')[1]
    if domain in domcount:
        domcount[domain] += 1
    else:
        domcount[domain] = 1
    newline = [domain]
    newline.extend(line[0:3])
    if line[2]:
        n,unit = line[2].split(' ')
        if n == '0' and unit == 'B':
            n = 0
            newline.append('%d' % n)
        else:
            n = float(n)
            if unit == 'GB':
                n = n * 1024 * 1024
            if unit == 'MB':
                n = n * 1024
            if unit == 'B':
                n = n / 1024
            if n > 10.0:
                n = int(n)
                newline.append('%d' % n)
            else:
                newline.append('%.2f' % n)
        if domain in domsize:
            domsize[domain] = domsize[domain] + float(n)
        else:
            domsize[domain] = float(n)
    else:
        newline.append('')
    if line[3]:
        newline.append('%s-%s-%s' % (line[3][0:4], line[3][4:6], line[3][6:8]))
    else:
        newline.append('')
    if line[4]:
        newline.append('%s-%s-%s' % (line[4][0:4], line[4][4:6], line[4][6:8]))
    else:
        newline.append('')
    writer.writerow(newline)

for domain, count in domcount.items():
    size = domsize[domain] if domain in domsize else 0
    writer.writerow([domain, count, '', '', str(int(size)), '', ''])
