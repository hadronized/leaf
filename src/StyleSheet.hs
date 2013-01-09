module StyleSheet where

import HTML (Selector(..))

-- wrapper
styleWrapper = ID "wrapper"

-- wrapper header
styleWrapperHeader,styleWrapperHeaderTitle,styleWrapperHeaderSlog :: Selector
styleWrapperHeader       = ID "wrapper_header"
styleWrapperHeaderTitle  = ID "wrapper_header_title"
styleWrapperHeaderSlog   = ID "wrapper_header_slogan"

-- wrapper footer
styleWrapperFooter          = ID "wrapper_footer"
styleWrapperFooterCopyright = ID "wrapper_footer_copyright"
styleWrapperFooterGenerator = ID "wrapper_footer_generator"

-- wrapper navbar
styleWrapperNavbar     = ID    "wrapper_navbar"
styleWrapperNavbarTab  = ID    "wrapper_navbar_tab"
styleWrapperNavbarItem = Class "wrapper_navbar_item"

-- wrapper content
styleWrapperContent    = ID "wrapper_content"