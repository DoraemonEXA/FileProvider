import XCTest
@testable import FilesProvider

final class WebDAVParsingTests: XCTestCase {
    func testDavResponseParsesDirectoryAndFileEntries() throws {
        let xml = """
        <?xml version=\"1.0\" encoding=\"utf-8\"?>
        <d:multistatus xmlns:d=\"DAV:\">
          <d:response>
            <d:href>/dav/Documents/</d:href>
            <d:propstat>
              <d:prop>
                <d:displayname>Documents</d:displayname>
                <d:resourcetype><d:collection/></d:resourcetype>
                <d:getlastmodified>Mon, 12 Apr 2021 14:15:22 GMT</d:getlastmodified>
              </d:prop>
              <d:status>HTTP/1.1 200 OK</d:status>
            </d:propstat>
          </d:response>
          <d:response>
            <d:href>/dav/Documents/readme.txt</d:href>
            <d:propstat>
              <d:prop>
                <d:displayname>readme.txt</d:displayname>
                <d:getcontentlength>42</d:getcontentlength>
                <d:getcontenttype>text/plain</d:getcontenttype>
              </d:prop>
              <d:status>HTTP/1.1 200 OK</d:status>
            </d:propstat>
          </d:response>
        </d:multistatus>
        """

        let baseURL = try XCTUnwrap(URL(string: "https://example.com/dav/"))
        let responses = DavResponse.parse(xmlResponse: Data(xml.utf8), baseURL: baseURL)

        XCTAssertEqual(responses.count, 2)

        let directory = WebDavFileObject(responses[0])
        XCTAssertEqual(directory.name, "Documents")
        XCTAssertEqual(directory.contentType, .directory)
        XCTAssertTrue(directory.path.hasPrefix("/Documents"))

        let file = WebDavFileObject(responses[1])
        XCTAssertEqual(file.name, "readme.txt")
        XCTAssertEqual(file.size, 42)
        XCTAssertEqual(file.contentType, .plainText)
        XCTAssertEqual(file.path, "/Documents/readme.txt")
    }

    func testDavResponsePercentEncodesSpaceInHref() throws {
        let xml = """
        <?xml version=\"1.0\" encoding=\"utf-8\"?>
        <d:multistatus xmlns:d=\"DAV:\">
          <d:response>
            <d:href>/dav/with space/video clip.mp4</d:href>
            <d:propstat>
              <d:prop>
                <d:getcontenttype>video/mp4</d:getcontenttype>
              </d:prop>
              <d:status>HTTP/1.1 200 OK</d:status>
            </d:propstat>
          </d:response>
        </d:multistatus>
        """

        let baseURL = try XCTUnwrap(URL(string: "https://example.com/dav/"))
        let responses = DavResponse.parse(xmlResponse: Data(xml.utf8), baseURL: baseURL)
        let response = try XCTUnwrap(responses.first)

        XCTAssertEqual(response.href.path, "/dav/with space/video clip.mp4")

        let file = WebDavFileObject(response)
        XCTAssertEqual(file.path, "/with space/video clip.mp4")
        XCTAssertEqual(file.contentType, .mpeg4)
    }
}
