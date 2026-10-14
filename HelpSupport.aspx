<%@ Page Title="Help & Support - Creation Car Care" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="HelpSupport.aspx.cs" Inherits="creation_car_care.HelpSupport" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .help-wrapper {
            max-width: 900px;
            margin: 30px auto;
            padding: 0 15px;
        }
        .help-header {
            margin-bottom: 28px;
        }
        .help-header h1 {
            font-size: 26px;
            font-weight: 800;
            color: #111827;
            margin: 0 0 6px 0;
        }
        .help-header p {
            font-size: 14px;
            color: #6b7280;
            margin: 0;
        }
        /* Top 2 Cards */
        .contact-cards-grid {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 20px;
            margin-bottom: 35px;
        }
        .contact-card {
            border-radius: 16px;
            padding: 24px;
            display: flex;
            align-items: center;
            gap: 18px;
            text-decoration: none;
            transition: transform 0.2s, box-shadow 0.2s;
        }
        .contact-card:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 20px rgba(0,0,0,0.06);
        }
        .card-whatsapp {
            background: #f0fdf4;
            border: 1.5px solid #bbf7d0;
        }
        .card-call {
            background: #fffcf8;
            border: 1.5px solid #fed7aa;
        }
        .contact-icon-circle {
            width: 48px;
            height: 48px;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 24px;
            flex-shrink: 0;
        }
        .circle-whatsapp {
            background: #22c55e;
            color: #ffffff;
        }
        .circle-call {
            background: #ea580c;
            color: #ffffff;
        }
        .contact-card-info h3 {
            font-size: 16px;
            font-weight: 800;
            color: #111827;
            margin: 0 0 3px 0;
        }
        .contact-card-info span {
            font-size: 12.5px;
            color: #6b7280;
            display: block;
            margin-bottom: 4px;
        }
        .contact-action-link {
            font-size: 12px;
            font-weight: 800;
        }
        .link-green {
            color: #16a34a;
        }
        .link-orange {
            color: #ea580c;
        }
        /* FAQ Section */
        .faq-title {
            font-size: 18px;
            font-weight: 800;
            color: #111827;
            margin-bottom: 18px;
        }
        .faq-item {
            background: #ffffff;
            border: 1.5px solid #e5e7eb;
            border-radius: 12px;
            margin-bottom: 12px;
            overflow: hidden;
            transition: border-color 0.2s;
        }
        .faq-item:hover {
            border-color: #fdba74;
        }
        .faq-question {
            padding: 18px 22px;
            font-size: 14.5px;
            font-weight: 700;
            color: #111827;
            cursor: pointer;
            display: flex;
            justify-content: space-between;
            align-items: center;
            user-select: none;
        }
        .faq-answer {
            padding: 0 22px 18px 22px;
            font-size: 13.5px;
            color: #4b5563;
            line-height: 1.6;
            display: none;
        }
        .faq-item.active .faq-answer {
            display: block;
        }
        .faq-item.active {
            border-color: #ea580c;
            background: #fffcf8;
        }
        .faq-arrow {
            color: #9ca3af;
            font-size: 14px;
            transition: transform 0.2s;
        }
        .faq-item.active .faq-arrow {
            transform: rotate(90deg);
            color: #ea580c;
        }
        @media (max-width: 650px) {
            .contact-cards-grid {
                grid-template-columns: 1fr;
            }
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="help-wrapper">
        
        <!-- Header -->
        <div class="help-header">
            <h1>Help &amp; Support</h1>
            <p>Get instant assistance or browse through frequently asked questions.</p>
        </div>

        <!-- 2 Action Cards -->
        <div class="contact-cards-grid">
            
            <!-- WhatsApp Card -->
            <a href="https://wa.me/919876543210" target="_blank" class="contact-card card-whatsapp">
                <div class="contact-icon-circle circle-whatsapp">&#128172;</div>
                <div class="contact-card-info">
                    <h3>WhatsApp Support</h3>
                    <span>Instant Chat Support</span>
                    <span class="contact-action-link link-green">Chat with us &rarr;</span>
                </div>
            </a>

            <!-- Call Studio Card -->
            <a href="tel:+919876543210" class="contact-card card-call">
                <div class="contact-icon-circle circle-call">&#128222;</div>
                <div class="contact-card-info">
                    <h3>Call Studio</h3>
                    <span>9:00 AM - 8:00 PM</span>
                    <span class="contact-action-link link-orange">Call Now &rarr;</span>
                </div>
            </a>

        </div>

        <!-- FAQ Section -->
        <div class="faq-title">Frequently Asked Questions</div>

        <!-- FAQ 1 -->
        <div class="faq-item active">
            <div class="faq-question" onclick="toggleFaq(this)">
                <span>How can I reschedule my car booking?</span>
                <span class="faq-arrow">&rsaquo;</span>
            </div>
            <div class="faq-answer">
                You can easily reschedule your appointment from the <b>My Bookings</b> section under the "Upcoming" tab. Click the <b>Reschedule</b> button on your booking card, select a convenient new date and slot, and confirm.
            </div>
        </div>

        <!-- FAQ 2 -->
        <div class="faq-item">
            <div class="faq-question" onclick="toggleFaq(this)">
                <span>What is the cancellation policy &amp; fees?</span>
                <span class="faq-arrow">&rsaquo;</span>
            </div>
            <div class="faq-answer">
                Cancellations made at least 2 hours before the scheduled slot are completely free. If cancelled within 2 hours of the slot, a nominal studio preparation charge of &#8377;99 may apply.
            </div>
        </div>

        <!-- FAQ 3 -->
        <div class="faq-item">
            <div class="faq-question" onclick="toggleFaq(this)">
                <span>Do you provide doorstep car care service?</span>
                <span class="faq-arrow">&rsaquo;</span>
            </div>
            <div class="faq-answer">
                Yes! We offer doorstep washing, interior foam spa, and sanitization services across Rajkot with zero doorstep visit charges. High-tech treatments like Ceramic Coating and PPF are performed in our controlled dust-free studio.
            </div>
        </div>

        <!-- FAQ 4 -->
        <div class="faq-item">
            <div class="faq-question" onclick="toggleFaq(this)">
                <span>How long does PPF application take?</span>
                <span class="faq-arrow">&rsaquo;</span>
            </div>
            <div class="faq-answer">
                Full Body Paint Protection Film (PPF) typically takes 2 to 3 days. This includes multi-stage paint decontamination, panel surface preparation, precision computer film cutting, bubble-free application, and 24-hour curing.
            </div>
        </div>

    </div>

    <script type="text/javascript">
        function toggleFaq(element) {
            var item = element.parentElement;
            item.classList.toggle('active');
        }
    </script>
</asp:Content>
