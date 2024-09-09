<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Gallery Page</title>
    <link rel="stylesheet" href="./css/style.css">
    <link rel="stylesheet" href="./css/gallery.css">
</head>

<body>
    <header>
        <div class="container">
            <%@ include file="navbar.jsp" %>
        </div>
    </header>

    <main>
        <div class="container gallery">
            <h2>Our Gallery</h2>
            <div class="gallery-grid">
                <div class="gallery-item" onclick="openModal('<%= request.getContextPath() %>/assets/images/privatediningroom.jpg', 'Private Dining - Our exclusive private dining room offers a secluded space for special occasions and business meetings.')">
                    <div class="gallery-item-inner">
                        <img src="<%= request.getContextPath() %>/assets/images/privatediningroom.jpg" alt="Private Dining">
                    </div>
                    <div class="gallery-item-content">
                        <h3>Private Dining</h3>
                        <p>Our exclusive private dining room offers a secluded space for special occasions and business meetings.</p>
                    </div>
                </div>
                <div class="gallery-item" onclick="openModal('<%= request.getContextPath() %>/assets/images/privatediningroom.jpg', 'Private Dining - Our exclusive private dining room offers a secluded space for special occasions and business meetings.')">
                    <div class="gallery-item-inner">
                        <img src="<%= request.getContextPath() %>/assets/images/signaturedishes.jpg" alt="Private Dining">
                    </div>
                    <div class="gallery-item-content">
                        <h3>Signature Dishes</h3>
                        <p>Our chef's special signature dishes, crafted with the finest ingredients and served with artistic presentation.</p>
                    </div>
                </div>
                <div class="gallery-item" onclick="openModal('<%= request.getContextPath() %>/assets/images/privatediningroom.jpg', 'Private Dining - Our exclusive private dining room offers a secluded space for special occasions and business meetings.')">
                    <div class="gallery-item-inner">
                        <img src="<%= request.getContextPath() %>/assets/images/outdoor.jpg" alt="Private Dining">
                    </div>
                    <div class="gallery-item-content">
                        <h3>Outdoor Dining</h3>
                        <p>Enjoy your meal with a breathtaking view from our outdoor seating area, surrounded by lush greenery.</p>
                    </div>
                </div>
                <!-- Repeat gallery-item for other images -->
            </div>
        </div>
    </main>

    <footer>
        <div class="container">
            <p>&copy; 2024 ABC Restaurant. All rights reserved.</p>
        </div>
    </footer>

    <!-- Modal for full image view -->
    <div id="galleryModal" class="modal">
        <span class="close" onclick="closeModal()">&times;</span>
        <div class="modal-content">
            <img id="modalImage" class="modal-image" src="" alt="">
            <div id="modalCaption" class="modal-caption"></div>
        </div>
    </div>

    <script>
        function openModal(imageSrc, captionText) {
            document.getElementById('galleryModal').style.display = 'block';
            document.getElementById('modalImage').src = imageSrc;
            document.getElementById('modalCaption').innerText = captionText;
        }

        function closeModal() {
            document.getElementById('galleryModal').style.display = 'none';
        }
    </script>
</body>

</html>
