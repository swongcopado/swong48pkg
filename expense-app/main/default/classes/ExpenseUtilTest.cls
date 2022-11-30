
@isTest public class ExpenseUtilTest {
    @isTest public static void testSayHello() {
        String result = ExpenseUtil.sayHello();
        System.assertEquals('Hello',result,'Say Hello did not say hello');
    }
}
