@isTest
public class CalculatorServiceMock implements WebserviceMock {

   public String mode;
   public static String ADD_MODE = 'ADD_MODE';
   public static String SUB_MODE = 'SUB_MODE';
   public static String MUL_MODE = 'MUL_MODE';
   public static String DIV_MODE = 'DIV_MODE';

    /*
    *   Constructor is used to set the mode in which the mock is called,
    *   It'll help the mock class to form the correct dummy response according to the callout invoked
    */
   public CalculatorServiceMock(String mockMode) {
       this.mode = mockMode;
   }

    // This method is declared in WebServiceMock interface and needs to be overridden by our mock class
    public void doInvoke(
           Object stub,
           Object request,
           Map<String, Object> response,
           String endpoint,
           String soapAction,
           String requestName,
           String responseNS,
           String responseName,
           String responseType) {

        /*
        *   Checking the mode and forming the correct response for mock callout.
        *   We're using the auto-genrated response wrappers from CalculatorService class
        *   and the response variable received as a parameter for setup the mock response
        */
        if(mode == ADD_MODE) {
            tempuriOrg.AddResponse_element addResponse = new tempuriOrg.AddResponse_element();
            addResponse.AddResult = 9;
	        response.put('response_x', addResponse);
        }
        else if(mode == SUB_MODE) {
            tempuriOrg.SubtractResponse_element subtractResponse = new tempuriOrg.SubtractResponse_element();
            subtractResponse.SubtractResult = 3;
	        response.put('response_x', subtractResponse);
        }
        else if(mode == MUL_MODE) {
            tempuriOrg.MultiplyResponse_element multiplyResponse = new tempuriOrg.MultiplyResponse_element();
            multiplyResponse.MultiplyResult = 18;
	        response.put('response_x', multiplyResponse);
        }
        else if(mode == DIV_MODE) {
            tempuriOrg.DivideResponse_element divideResponse = new tempuriOrg.DivideResponse_element();
            divideResponse.DivideResult = 2;
            response.put('response_x', divideResponse);
        }
   }
}