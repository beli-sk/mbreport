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
zmprov -l gaa | while read mailbox ; do
	echo "$mailbox" >&2
	# mailbox size
	size=`zmmailbox -z -m "$mailbox" gms`
	# last login, account status, create timestamp
	data="`zmprov ga $mailbox zimbraLastLogonTimestamp zimbraAccountStatus zimbraCreateTimestamp`"
	lastlog=`echo "$data" | grep '^zimbraLastLogonTimestamp' | cut -d' ' -f2`
	stat=`echo "$data" | grep '^zimbraAccountStatus' | cut -d' ' -f2`
	create=`echo "$data" | grep '^zimbraCreateTimestamp' | cut -d' ' -f2`
	echo "$mailbox,$stat,$size,$create,$lastlog"
	#(( count+=1 ))
	#if (( count>=10 )) ; then
	#	break
	#fi
done
