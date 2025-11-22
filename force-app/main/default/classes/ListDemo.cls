public class ListDemo {
    public static void demo(){
        List<String> st=new List<String>();
        st.add('venitha');
        st.add('yamuna');
        st.add('dhanya');
        st.add('siddarth');
        System.debug(st);
        st.clear();
        System.debug(st);
    }
}