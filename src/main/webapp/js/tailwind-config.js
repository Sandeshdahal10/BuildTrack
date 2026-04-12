tailwind.config = {
    theme: {
        extend: {
            colors: {
                'bt': { ... },
                'admin': { ... },
                'worker': { ... },
                'client': { ... },
                'amber': { ... }
            },
            fontFamily: {
                'sans': ['Inter', 'system-ui', '-apple-system', 'BlinkMacSystemFont', 'Segoe UI', 'Roboto', 'sans-serif'],
            },
            maxWidth: {
                'sidebar': '260px',
                'content': '1280px',
            },
            minWidth: {
                'sidebar': '260px',
            },
            animation: {
                'fade-in': 'fadeIn 0.3s ease-in-out',
                'slide-in': 'slideIn 0.3s ease-in-out',
                'pulse-slow': 'pulse 3s infinite',
            },
            keyframes: {
                fadeIn: {
                    '0%': { opacity: '0' },
                    '100%': { opacity: '1' },
                },
                slideIn: {
                    '0%': { transform: 'translateX(-100%)' },
                    '100%': { transform: 'translateX(0)' },
                },
            },
        },
    },
}