import sys
import re

try:
    with open(r"c:\Users\hp\OneDrive\Desktop\web2\index.html", "r", encoding="utf-8") as f:
        idx1 = f.read()

    with open(r"c:\Users\hp\OneDrive\Desktop\web2\index2.html", "r", encoding="utf-8") as f:
        idx2 = f.read()

    # Find parts
    # 1. CSS
    css_start = "/* ===== DEEP-SPACE CANVAS BACKGROUND ===== */"
    css_end = "/* Box positions are assigned dynamically by JS – no fixed CSS IDs needed */\n  </style>"
    css_block = idx1[idx1.find(css_start):idx1.find(css_end) + len(css_end) - 10]

    # 2. HTML
    html_start = "<!-- Deep-Space Background Canvas -->"
    html_end = "<!-- HUD Info Boxes -->"
    html_end_divs = "    <div class=\"pl-info-box\" id=\"pl-box-5\"><div class=\"pl-info-label\">Status</div><div class=\"pl-info-value\" id=\"pl-box-5-val\"></div></div>\n  </div>"
    
    start_index = idx1.find(html_start)
    end_index = idx1.find(html_end_divs) + len(html_end_divs)
    html_block = idx1[start_index:end_index]

    # 3. JS1
    js1_start = "<script>\n    (function () {\n      // All text snippets drawn from the webpage content"
    js1_end = "      };\n    })();\n  </script>"
    start_js1 = idx1.find(js1_start)
    end_js1 = idx1.find(js1_end) + len(js1_end)
    js1_block = idx1[start_js1:end_js1]

    # 4. JS2
    js2_start = "<!-- ===== MERGED ANIMATION ENGINE (Preloader → Persistent Background) ===== -->"
    js2_end = "    })();\n  </script>"
    start_js2 = idx1.find(js2_start)
    end_js2 = idx1.find(js2_end, start_js2) + len(js2_end)
    js2_block = idx1[start_js2:end_js2]

    # Insert into index2.html
    # Replace CSS
    css_target = "        .tl-cosmic-container * {\n            font-family: 'League Spartan', sans-serif !important;\n        }\n    </style>"
    if css_target in idx2:
        idx2 = idx2.replace(css_target, "\n        .tl-cosmic-container * {\n            font-family: 'League Spartan', sans-serif !important;\n        }\n\n" + css_block + "\n    </style>")
        print("CSS inserted successfully")
    else:
        print("CSS target missing")

    # Replace HTML
    body_target = "<body class=\"__className_36bd41 bg-[#030014] overflow-y-scroll overflow-x-hidden relative\">"
    if body_target in idx2:
        idx2 = idx2.replace(body_target, body_target + "\n\n  " + html_block)
        print("HTML inserted successfully")
    elif "<body " in idx2:
        body_str = idx2[idx2.find("<body"):idx2.find(">", idx2.find("<body"))+1]
        idx2 = idx2.replace(body_str, body_str + "\n\n  " + html_block)
        print("HTML inserted successfully (alternative)")
    else:
        print("HTML target missing")

    # Replace JS
    body_close = "    </script>\n</body>\n\n</html>"
    if "</body>\n\n</html>" in idx2:
        idx2 = idx2.replace("</body>\n\n</html>", "\n  " + js1_block + "\n\n  " + js2_block + "\n\n</body>\n\n</html>")
        print("JS inserted successfully")
    elif "</body>\n</html>" in idx2:
        idx2 = idx2.replace("</body>\n</html>", "\n  " + js1_block + "\n\n  " + js2_block + "\n\n</body>\n</html>")
        print("JS inserted successfully")
    elif "</body>" in idx2:
        idx2 = idx2.replace("</body>", "\n  " + js1_block + "\n\n  " + js2_block + "\n\n</body>")
        print("JS inserted successfully (fallback)")
    else:
        print("JS target missing")
        
    with open(r"c:\Users\hp\OneDrive\Desktop\web2\index2.html", "w", encoding="utf-8") as f:
        f.write(idx2)
        
    print("Done writing to index2.html")

except Exception as e:
    import traceback
    traceback.print_exc()
