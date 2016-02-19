import dart.async {
    Future,
    Stream
}

shared
interface HttpRequest {
    shared formal
    HttpResponse response;
}

shared
interface HttpResponse {
    // TODO methods really from IOSink

    shared formal
    void write(Anything obj);

    shared formal
    void close();
}

shared
interface HttpServer satisfies Stream<HttpRequest> {
    // TODO `String | InternetAddress address`
    shared formal
    Future<HttpServer> bind(String address, Integer port, Integer backlong = 0,
            Boolean v6Only = false, Boolean shared = false);
}
