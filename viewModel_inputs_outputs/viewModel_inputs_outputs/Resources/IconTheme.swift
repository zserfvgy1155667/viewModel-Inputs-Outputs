/// 圖片的基本實作
protocol ImageTheme {
    var icon_basic_arrow_back_w: String { get }
    var icon_basic_arrow_back: String { get }
    var icon_basic_close_w: String { get }
    var icon_basic_close: String { get }
}

struct LightImageTheme : ImageTheme {
    let icon_basic_arrow_back_w: String  = "icon_basic_arrow_back_w"
    let icon_basic_arrow_back: String  = "icon_basic_arrow_back"
    let icon_basic_close_w: String  = "icon_basic_close_w"
    let icon_basic_close: String  = "icon_basic_close"
}

struct DarkImageTheme : ImageTheme {
    let icon_basic_arrow_back_w: String  = "icon_basic_arrow_back_w"
    let icon_basic_arrow_back: String  = "icon_basic_arrow_back"
    let icon_basic_close_w: String  = "icon_basic_close_w"
    let icon_basic_close: String  = "icon_basic_close"
}
