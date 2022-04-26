#include <gtest/gtest.h>
bool isEven(int number) { return number % 2 == 0; }

TEST(isEven, isEvenTestCase) {
    ASSERT_TRUE(isEven(2));
    EXPECT_TRUE(isEven(4));
    ASSERT_FALSE(isEven(3));
    EXPECT_FALSE(isEven(5));
}

TEST(isEven, isEvenTestCase2) {
    ASSERT_TRUE(isEven(2));
    EXPECT_TRUE(isEven(4));
    ASSERT_FALSE(isEven(3));
    EXPECT_FALSE(isEven(5));
}

