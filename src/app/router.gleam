import wisp.{type Request, type Response}
import gleam/string_builder
import gleam/http.{Get}
import app/web

/// The HTTP request handler- your application!
/// 
pub fn handle_request(req: Request) -> Response {
  // Apply the middleware stack for this request/response.
  use req <- web.middleware(req)

  case wisp.path_segments(req) {
    [] -> home_page(req)
    ["dashboard"] -> dashboard(req)
    ["search_sets"] -> settings(req)
    _ -> wisp.not_found()
  }
}

fn home_page(req: Request) -> Response {
  use <- wisp.require_method(req, Get)

  let html = string_builder.from_string("Hello")

  wisp.ok()
  |> wisp.html_body(html)
}

fn dashboard(req: Request) -> Response {
  use <- wisp.require_method(req, Get)

  let html = string_builder.from_string("Dashboard")

  wisp.ok()
  |> wisp.html_body(html)
}

fn settings(req: Request) -> Response {
  use <- wisp.require_method(req, Get)

  let html = string_builder.from_string("Settings")

  ok_wrapper(html)
}

fn ok_wrapper(html: string_builder.StringBuilder) -> Response {
  wisp.ok() |> wisp.html_body(html)
}
