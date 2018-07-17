#include "build/temp/_test_functionsundertest.c"
#include "functionsundertest.h"
#include "unity.h"


void setUp(void)

{

}



void tearDown(void)

{

}



void test_AverageThreeBytes_should_AverageMidRangeValues(void)

{

UnityAssertEqualNumber((UNITY_INT)(UNITY_INT8 )((40)), (UNITY_INT)(UNITY_INT8 )((AverageThreeBytes(30, 40, 50))), (

((void *)0)

), (UNITY_UINT)(14), UNITY_DISPLAY_STYLE_HEX8);

UnityAssertEqualNumber((UNITY_INT)(UNITY_INT8 )((40)), (UNITY_INT)(UNITY_INT8 )((AverageThreeBytes(10, 70, 40))), (

((void *)0)

), (UNITY_UINT)(15), UNITY_DISPLAY_STYLE_HEX8);

UnityAssertEqualNumber((UNITY_INT)(UNITY_INT8 )((33)), (UNITY_INT)(UNITY_INT8 )((AverageThreeBytes(33, 33, 33))), (

((void *)0)

), (UNITY_UINT)(16), UNITY_DISPLAY_STYLE_HEX8);

}



void test_AverageThreeBytes_should_AverageHighValues(void)

{

UnityAssertEqualNumber((UNITY_INT)(UNITY_INT8 )((80)), (UNITY_INT)(UNITY_INT8 )((AverageThreeBytes(70, 80, 90))), (

((void *)0)

), (UNITY_UINT)(21), UNITY_DISPLAY_STYLE_HEX8);

UnityAssertEqualNumber((UNITY_INT)(UNITY_INT8 )((127)), (UNITY_INT)(UNITY_INT8 )((AverageThreeBytes(127, 127, 127))), (

((void *)0)

), (UNITY_UINT)(22), UNITY_DISPLAY_STYLE_HEX8);

UnityAssertEqualNumber((UNITY_INT)(UNITY_INT8 )((84)), (UNITY_INT)(UNITY_INT8 )((AverageThreeBytes(0, 126, 126))), (

((void *)0)

), (UNITY_UINT)(23), UNITY_DISPLAY_STYLE_HEX8);

}
