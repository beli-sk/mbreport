#!/bin/bash
#
# mbreport - per mailbox stats from Zimbra mail server
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
count=0
zmprov -l gad | while read domain ; do
	echo "$domain" >&2
	data="`zmprov gd $domain zimbraDomainStatus zimbraDomainType`"
	stat=`echo "$data" | grep '^zimbraDomainStatus' | cut -d' ' -f2`
	typ=`echo "$data" | grep '^zimbraDomainType' | cut -d' ' -f2`
	echo "$domain,$stat,$typ"
done
