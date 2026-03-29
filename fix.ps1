$content = Get-Content 'c:\Users\samir\Downloads\web2\index.html' -TotalCount 2257;
$newPart = @"
  <script>
    document.addEventListener("DOMContentLoaded", () => {
      const trailContainer = document.createElement("div");
      trailContainer.style.cssText = "position:fixed;top:0;left:0;width:100vw;height:100vh;pointer-events:none;z-index:9999;";
      document.body.appendChild(trailContainer);
      let lastX = 0; let lastY = 0;
      document.addEventListener("mousemove", (e) => {
        const deltaX = e.clientX - lastX;
        const deltaY = e.clientY - lastY;
        if (Math.abs(deltaX) < 5 && Math.abs(deltaY) < 5) return;
        lastX = e.clientX; lastY = e.clientY;
        const dot = document.createElement("div");
        const colors = ["#a855f7", "#06b6d4", "#c084fc", "#22d3ee", "#ffffff"];
        const rc = colors[Math.floor(Math.random() * colors.length)];
        Object.assign(dot.style, { position: "absolute", left: e.clientX + "px", top: e.clientY + "px", width: "6px", height: "6px", backgroundColor: rc, borderRadius: "50%", boxShadow: "0 0 10px "+rc, pointerEvents: "none", transform: "translate(-50%, -50%)" });
        trailContainer.appendChild(dot);
        if (typeof gsap !== "undefined") gsap.to(dot, { scale: 0, opacity: 0, duration: 0.6, onComplete: () => dot.remove() });
      });
    });
  </script>
  <div id="cosmic-rocket" class="fixed pointer-events-none z-[9999]" style="width:45px;height:45px;left:0;top:0;transform-origin:center;">
    <svg viewBox="0 0 100 100" fill="none" xmlns="http://www.w3.org/2000/svg">
      <path d="M50 5 L75 45 V85 L50 95 L25 85 V45 L50 5Z" stroke="white" stroke-width="2.5" stroke-linejoin="round"/>
      <path d="M25 70 L10 90 L25 80" stroke="white" stroke-width="2.5" stroke-linecap="round"/>
      <path d="M75 70 L90 90 L75 80" stroke="white" stroke-width="2.5" stroke-linecap="round"/>
      <path id="rocket-flame-2" d="M40 95 L50 120 L60 95Z" fill="#06b6d4">
        <animate attributeName="opacity" values="0.3;1;0.3" dur="0.1s" repeatCount="indefinite" />
        <animate attributeName="d" values="M40 95 L50 115 L60 95Z;M40 95 L50 130 L60 95Z;M40 95 L50 115 L60 95Z" dur="0.2s" repeatCount="indefinite" />
      </path>
    </svg>
  </div>
  <script>
    document.addEventListener("DOMContentLoaded", () => {
      const rocket = document.getElementById("cosmic-rocket");
      if (!rocket || typeof gsap === "undefined") return;
      let cx = window.innerWidth / 2; let cy = window.innerHeight / 2;
      function move() {
        const nx = Math.random() * (window.innerWidth - 100) + 50;
        const ny = Math.random() * (window.innerHeight - 100) + 50;
        const ang = Math.atan2(ny - cy, nx - cx) * (180 / Math.PI) + 90;
        gsap.to(rocket, { x: nx, y: ny, rotation: ang, duration: 3 + Math.random() * 5, ease: "sine.inOut", onUpdate: () => {
          if(Math.random() > 0.45) {
            const p = document.createElement("div");
            p.className = "fixed rounded-full pointer-events-none z-[9998]";
            Object.assign(p.style, { width:"4px", height:"4px", left: (gsap.getProperty(rocket, "x") + 22) + "px", top: (gsap.getProperty(rocket, "y") + 22) + "px", background: "rgba(255,255,255,0.4)", boxShadow: "0 0 8px #06b6d4" });
            document.body.appendChild(p);
            gsap.to(p, { opacity: 0, scale: 0.1, duration: 1.2, onComplete: () => p.remove() });
          }
        }, onComplete: () => { cx = nx; cy = ny; setTimeout(move, 500); } });
      }
      gsap.set(rocket, { x: cx, y: cy }); move();
    });
  </script>
</body>
</html>
"@;
$content + $newPart | Set-Content 'c:\Users\samir\Downloads\web2\index.html'