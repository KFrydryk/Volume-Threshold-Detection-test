#include "test-driver.h"
#include "test-lib.h"

int main()
{	
	int result = 0;

	result = testlib(result);
	result = testdriver(result);

	while(1){}
	
	return 0;
}