// SPDX-License-Identifier: GPL-2.0-or-later
/*
 *  Copyright (c) SUSE LLC, 2019
 *  Author: Christian Amann <camann@suse.com>
 */
/*
 * Dummy program used in acct02
 */

#include <unistd.h>

int main(void)
{
#ifdef DUNE
 if(dune_enter()){
 return 1;
 }
#endif
	sleep(1);
	return 128;
}
