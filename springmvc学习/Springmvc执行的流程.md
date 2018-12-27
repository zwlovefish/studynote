# SpringMVC执行的流程
1. 客户端发送请求------>DispatcherServlet拦截
2. DispatcherServlet 对请求的URL解析，得到URI，根据URI调用HandlerMapping获得该Handler配置的所有相关对象，包括Handler对象以及Handler对象对应的拦截器，这些对象会被封装到一个HandlerExecutionChain对象中返回
3. Dispatcher根据获得的Handler，选择一个合适的HandlerAdapter。HandlerAdapter会被用于处理多种Handler，调用Handler实际处理请求的方法，例如hello方法。
4. 提取请求中的数据，开始执行Handler(Controller)。在填充Handler的入参过程中，根据配置，Spring会做一些额外的攻入：如消息转换，数据转换，数据格式化，数据验证
5. Handler执行完成后，向Dispatcher返回一个ModelAndView对象，ModelAndView对象中应该包含视图名或视图名和模型
6. 根据返回的ModelAndView对象，选择一个合适的ViewResolver(视图解析器)返回给DispatcherServlet
7. ViewSolver结合Model和View来渲染视图。
8. 将视图渲染结果返回给客户端。